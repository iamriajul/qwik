import { component$ } from '@builder.io/qwik';
import Container from '~/components/container';
import Layout from '~/components/layout';

export default component$(() => {
  return (
    <Layout>
      <Container position="center" width="small">
        <div class="felx-nowrap flex min-h-[calc(100vh-76px)] flex-col items-center justify-center">
          <div class="rounded-lg bg-white p-10 shadow-sm">
            <h1 class="h1 mb-20">Welcome</h1>
            <div class="flex items-center justify-between">
              <a
                href="/api/auth/signin"
                class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
                type="button">
                Sign In
              </a>
            </div>
          </div>
        </div>
      </Container>
    </Layout>
  );
});
