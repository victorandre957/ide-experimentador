import React, { useEffect, useState } from "react";
import LocalPlanForm from "../components/LocalPlanForm";
import axios from "axios";
import toast, { Toaster } from "react-hot-toast";

let existPlan = false;

const CreateLocalPlan = ({}) => {
  const [steps, setSteps] = useState([]);
  const [robotId, setRobotId] = useState(-1);

  useEffect(() => {
    const path = window.location.pathname.split("/");
    const robotId = Number(path[path.length - 1]);
    setRobotId(robotId);

    if (!Number.isNaN(robotId)) {
      axios
        .get(`/api/local_plan_steps/index_by_robot/${robotId}`)
        .then((response) => {
          existPlan = !!response.data;
          setSteps(response.data);
        })
        .catch((error) => {
          console.error("Erro ao carregar os passos:", error);
        });
    }
  }, []);

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

  const handleDeletePlan = () => {
    const fetchPromise = axios.delete(`local_plan_steps/${robotId}`, {
      robot_Id: robotId,
    });

    toast.promise(fetchPromise, {
      loading: "Deletando Plano Local",
      success: () => {
        setSteps([]);
        return "Plano Local criado com sucesso";
      },
      error: (err) => err.response?.data?.message || err.message,
    });
  };

  const handleSave = () => {
    const url = existPlan
      ? `/api/local_plan_steps/${robotId}`
      : "/api/local_plan_steps";

    let fetchPromise;
    if (!existPlan) {
      fetchPromise = axios.post(url, { local_plan: steps, robot_Id: robotId });

      toast.promise(fetchPromise, {
        loading: "Criando Plano Local",
        success: "Plano Local criado com sucesso",
        error: (err) => err.response?.data?.message || err.message,
      });
    } else {
      fetchPromise = axios.put(url, {
        local_plan: steps,
        robot_Id: robotId,
      });

      toast.promise(fetchPromise, {
        loading: "Atualizando o Plano Local",
        success: "Plano Local atualizado com sucesso",
        error: (err) => err.response?.data?.message || err.message,
      });
    }
  };

  return (
    <>
      <Toaster
        toastOptions={{
          success: {
            className: "bg-green-100 p-5 rounded",
            icon: (
              <span className="flex">
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
                  className="text-green-500"
                >
                  <path d="M20 6 9 17l-5-5" />
                </svg>
                Sucesso
              </span>
            ),
          },
          error: {
            className: "bg-red-100 p-5 rounded",
            icon: (
              <span className="flex">
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
                  className="text-red-500"
                >
                  <path d="M18 6 6 18" />
                  <path d="m6 6 12 12" />
                </svg>
                Algo deu errado
              </span>
            ),
          },
        }}
      />
      <div className="grid grid-cols-2 p-16">
        <div>
          <h1 className="text-3xl font-bold tracking-tight">
            Crie uma sequência de passos
          </h1>
          <div className="flex flex-col items-center w-full">
            <div className="w-full">
              {steps.map((step, index) => (
                <LocalPlanForm
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
        </div>

        <div className="flex justify-end items-start">
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
        </div>
      </div>
    </>
  );
};

export default CreateLocalPlan;
