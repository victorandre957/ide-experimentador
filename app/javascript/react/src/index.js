import { define } from 'remount'      
import Graph from "./components/Graph"
import CreateLocalPlan from "./pages/CreateLocalPlan";
import { wrapWithQueryProvider } from "./wrapWithQueryProvider";
                                      
define({ "create-local-plan-component": wrapWithQueryProvider(CreateLocalPlan) });
