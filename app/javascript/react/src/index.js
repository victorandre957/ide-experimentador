import { define } from "remount";
import CreateLocalPlan from "./pages/CreateLocalPlan";
import { wrapWithQueryProvider } from "./wrapWithQueryProvider";

define({ "create-local-plan-component": wrapWithQueryProvider(CreateLocalPlan) });
