import {RequestHandler} from "@builder.io/qwik-city";

// An endpoint to get the version of the app.
export const onGet: RequestHandler = async ctx => {
  ctx.json(200, {
    version: import.meta.env.PUBLIC_APP_VERSION || 'dev'
  });
}