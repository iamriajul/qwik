import { resumeIfNeeded } from '../core/container/resume';
import { assertDefined } from '../core/error/assert';
import { parseQRL } from '../core/qrl/qrl';
import type { QRLInternal } from '../core/qrl/qrl-class';
import { isSyncQrl } from '../core/qrl/qrl-class';
import { directGetAttribute } from '../core/render/fast-calls';
import { tryGetContext, type QContext } from '../core/state/context';
import { normalizeOnProp, PREVENT_DEFAULT } from '../core/state/listeners';
import { getWrappingContainer } from '../core/use/use-core';
import { fromCamelToKebabCase } from '../core/util/case';
import { QContainerSelector } from '../core/util/markers';
import { Q_FUNCS_PREFIX } from '../server/render';
import { createWindow } from './document';
import { getTestPlatform } from './platform';
import type { MockDocument, MockWindow } from './types';

/**
 * Creates a simple DOM structure for testing components.
 *
 * By default `EntityFixture` creates:
 *
 * ```html
 * <host q:view="./component_fixture.noop">
 *   <child></child>
 * </host>
 * ```
 *
 * @public
 */
export class ElementFixture {
  window: MockWindow;
  document: MockDocument;
  superParent: HTMLElement;
  parent: HTMLElement;
  host: HTMLElement;
  child: HTMLElement;

  constructor(options: ElementFixtureOptions = {}) {
    this.window = createWindow();
    this.document = this.window.document;
    this.superParent = this.document.createElement('super-parent');
    this.document.body.appendChild(this.superParent);
    this.parent = this.document.createElement('parent');
    this.superParent.appendChild(this.parent);
    if (options.html) {
      this.parent.innerHTML = options.html;
      this.host = this.parent.firstElementChild as HTMLElement;
      assertDefined(this.host, 'host element must be defined');
      this.host.querySelectorAll('script[q\\:func="qwik/json"]').forEach((script) => {
        const code = script.textContent;
        if (code?.startsWith(Q_FUNCS_PREFIX)) {
          const qFuncs = eval(code.substring(Q_FUNCS_PREFIX.length));
          const container = this.host.closest(QContainerSelector);
          (container as any as { qFuncs?: Function[] }).qFuncs = qFuncs;
        }
      });
      this.child = null!;
    } else {
      this.host = this.document.createElement(options.tagName || 'host');
      this.child = this.document.createElement('child');
      this.parent.appendChild(this.host);
      this.host.appendChild(this.child);
    }
  }
}

/** @public */
export interface ElementFixtureOptions {
  tagName?: string;
  html?: string;
}

/**
 * Trigger an event in unit tests on an element.
 *
 * Future deprecation candidate.
 *
 * @param element
 * @param selector
 * @param event
 * @returns
 * @public
 */
export async function trigger(
  root: Element,
  queryOrElement: string | Element | keyof HTMLElementTagNameMap | null,
  eventNameCamel: string,
  eventPayload: any = {}
): Promise<void> {
  const elements =
    typeof queryOrElement === 'string'
      ? Array.from(root.querySelectorAll(queryOrElement))
      : [queryOrElement];
  for (const element of elements) {
    const kebabEventName = fromCamelToKebabCase(eventNameCamel);
    const event = root.ownerDocument.createEvent('Event');
    event.initEvent(kebabEventName, true, true);
    Object.assign(event, eventPayload);
    const attrName = 'on:' + kebabEventName;
    await dispatch(element, attrName, event);
  }
  await getTestPlatform().flush();
}

/**
 * Dispatch
 *
 * @param element
 * @param attrName
 * @param event
 */
export const dispatch = async (element: Element | null, attrName: string, event: any) => {
  const preventAttributeName = PREVENT_DEFAULT + event.type;
  const collectListeners: { element: Element; qrl: QRLInternal }[] = [];
  const containerEl = element?.closest(QContainerSelector);
  containerEl && resumeIfNeeded(containerEl);
  while (element) {
    const preventDefault = element.hasAttribute(preventAttributeName);
    if (preventDefault) {
      event.preventDefault();
    }
    const ctx = tryGetContext(element);
    if (ctx) {
      for (const li of ctx.li) {
        if (li[0] === attrName) {
          // Ensure this is correct event type
          const qrl = li[1];
          if (isSyncQrl(qrl)) {
            qrl(event, element);
          } else {
            collectListeners.push({ element, qrl: qrl });
          }
        }
      }
    } else if (element.hasAttribute(attrName)) {
      directGetAttribute(element, attrName)!
        .split('/n')
        .map((qrl) => parseQRL(qrl, containerEl || undefined))
        .forEach((qrl) => {
          qrl(event, element);
        });
    }
    element = element.parentElement;
  }
  for (let i = 0; i < collectListeners.length; i++) {
    const { element, qrl } = collectListeners[i];
    await qrl.getFn([element, event], () => element.isConnected)(event, element);
  }
};
export function getEvent(elCtx: QContext, prop: string): any {
  return qPropReadQRL(elCtx, normalizeOnProp(prop));
}

export function qPropReadQRL(elCtx: QContext, prop: string): ((event: Event) => void) | null {
  const allListeners = elCtx.li;
  const containerEl = getWrappingContainer(elCtx.$element$);
  assertDefined(containerEl, 'container element must be defined');

  return (event) => {
    return Promise.all(
      allListeners
        .filter((li) => li[0] === prop)
        .map(([_, qrl]) => {
          qrl.$setContainer$(containerEl);
          return qrl(event);
        })
    );
  };
}
