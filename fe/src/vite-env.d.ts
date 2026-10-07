/// <reference types="vite/client" />

declare global {
  interface Window {
    __lastRoute?: { path: string; slug: string; query: string };
  }
}

export {};
