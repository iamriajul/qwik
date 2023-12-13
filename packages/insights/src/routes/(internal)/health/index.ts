import {RequestHandler} from "@builder.io/qwik-city";

export const onGet: RequestHandler = async ctx => {
  ctx.json(200, {status: 'ok'});
}