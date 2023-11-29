import { QueryClient, QueryClientProvider } from "@tanstack/react-query";

// Create a client
const queryClient = new QueryClient();

export function wrapWithQueryProvider(Component) {
  return () => (
    // Provide the client to your App
    <QueryClientProvider client={queryClient}>
      <Component />
    </QueryClientProvider>
  );
}
