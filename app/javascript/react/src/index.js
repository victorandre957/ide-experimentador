import { define } from "remount";
import Hello from "./pages/Hello";
import { wrapWithQueryProvider } from "./wrapWithQueryProvider";

define({ "hello-component": wrapWithQueryProvider(Hello) });
