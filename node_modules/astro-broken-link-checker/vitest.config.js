// vitest.config.js

import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    // Configure test environment and options here
    globals: true,
    environment: 'node',
    coverage: {
      provider: 'v8',
    },
  },
});
