import { define } from 'remount'      
import Hello from "./components/Hello"
import Graph from "./components/Graph"
import CreateLocalPlan from "./pages/CreateLocalPlan";
import { wrapWithQueryProvider } from "./wrapWithQueryProvider";
                                      
define({ 'hello-component': Hello, 'graph-component': Graph })
define({ "create-local-plan-component": wrapWithQueryProvider(CreateLocalPlan) });
