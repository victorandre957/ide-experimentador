import axios from "axios";
import LocalPlanForm from "./Form";
import toast from "react-hot-toast";

function LocalPlan({ steps, setSteps, robotId }) {
  const handleSave = () => {
    const url = `/api/local_plan_steps/${robotId}`;

    const fetchPromise = axios.put(url, {
      local_plan: steps,
      robot_Id: robotId,
    });

    toast.promise(fetchPromise, {
      loading: "Atualizando o Plano Local",
      success: "Plano Local atualizado com sucesso",
      error: (err) => err.response?.data?.message || err.message,
    });
  };

  return (
    <LocalPlanForm steps={steps} setSteps={setSteps} handleSave={handleSave} />
  );
}

export { LocalPlan };
export { DeleteLocalPlanButton } from "./DeleteButton";
