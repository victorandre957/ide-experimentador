import { define } from "remount";
import Hello from "./pages/CreatLocalPlan";
import { wrapWithQueryProvider } from "./wrapWithQueryProvider";

define({ "hello-component": wrapWithQueryProvider(Hello) });
