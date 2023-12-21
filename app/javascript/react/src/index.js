import { define } from "remount";
// import Hello from "./components/Hello"
// import Graph from "./components/Graph"
import LocalPlanPage from "./pages/LocalPlanPage";
import { wrapWithQueryProvider } from "./wrapWithQueryProvider";

// define({ 'hello-component': Hello, 'graph-component': Graph })
define({
  "create-local-plan-component": wrapWithQueryProvider(() =>
    LocalPlanPage({
      robotId: Number(
        window.location.pathname.split("/")[
          window.location.pathname.split("/").length - 1
        ]
      ),
    })
  ),
});
