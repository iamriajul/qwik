import {RequestHandler} from "@builder.io/qwik-city";

export const onRequest: RequestHandler = ctx => {
  ctx.cacheControl({
    noStore: true,
    noCache: true,
    private: true,
  });

  ctx.headers.set('X-Robots-Tag', 'noindex, nofollow');
};