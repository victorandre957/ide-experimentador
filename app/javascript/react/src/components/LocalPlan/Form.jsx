import LocalPlanStepForm from "./StepForm";

export default function LocalPlanForm({ steps, setSteps, handleSave }) {
  const handleChange = (index, value) => {
    steps[index] = value;
    setSteps([...steps]);
  };

  const handleAddStep = () => {
    setSteps([...steps, { skill: "", label: "", parameter: {} }]);
  };

  const handleRemoveStep = (index) => {
    setSteps(steps.filter((_, i) => i !== index));
  };

  return (
    <div className="flex flex-col items-center w-full">
      <div className="w-full">
        {steps.map((step, index) => (
          <LocalPlanStepForm
            key={index} // Adicione a chave única para cada Input
            step={step}
            stepIndex={index}
            onChange={handleChange}
            onRemove={handleRemoveStep}
          />
        ))}
      </div>
      <button
        className="rounded px-4 py-3 my-4 bg-zinc-100"
        onClick={handleAddStep}
      >
        Adicionar Novo Passo
      </button>
      <button
        className="rounded text-green-700 bg-green-100 px-4 py-3 flex gap-2 mr-auto mt-10"
        onClick={handleSave}
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
          <path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z" />
          <polyline points="17 21 17 13 7 13 7 21" />
          <polyline points="7 3 7 8 15 8" />
        </svg>
        Salvar Plano Local
      </button>
    </div>
  );
}
