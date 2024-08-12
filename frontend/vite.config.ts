import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vitest/config';
import { optimizeCss } from 'carbon-preprocess-svelte';

export default defineConfig({
	plugins: [sveltekit(), optimizeCss()],
	test: {
		include: ['src/**/*.{test,spec}.{js,ts}']
	}
});
