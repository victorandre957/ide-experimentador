import toast from "react-hot-toast";

export function DeleteLocalPlanButton({ robotId }) {
  const handleDeletePlan = () => {
    const fetchPromise = axios.delete(`/api/local_plan_steps/${robotId}`, {
      robot_Id: robotId,
    });
    toast.promise(fetchPromise, {
      loading: "Deletando Plano Local",
      success: () => {
        setSteps([]);
        return "Plano Local deletado com sucesso";
      },
      error: (err) => err.response?.data?.message || err.message,
    });
  };

  return (
    <button
      className="rounded text-red-700 bg-red-100 px-4 py-3 flex gap-2"
      onClick={handleDeletePlan}
    >
      <svg
        xmlns="http://www.w3.org/2000/svg"
        width="24"
        height="24"
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        strokeWidth="2"
        strokeLinecap="round"
        strokeLinejoin="round"
      >
        <path d="M3 6h18" />
        <path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6" />
        <path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2" />
        <line x1="10" x2="10" y1="11" y2="17" />
        <line x1="14" x2="14" y1="11" y2="17" />
      </svg>
      Deletar Plano Local
    </button>
  );
}
