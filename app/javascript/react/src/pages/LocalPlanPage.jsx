import React from "react";
import { DeleteLocalPlanButton, LocalPlan } from "../components/LocalPlan";
import { StyledToaster } from "../components/StyledToaster";
import { useLocalPlan } from "../hooks/useLocalPlan";

const LocalPlanPage = ({ robotId }) => {
  const [steps, setSteps] = useLocalPlan(robotId);

  return (
    <>
      <StyledToaster />
      <div className="grid grid-cols-2 p-16">
        <div>
          <h1 className="text-3xl font-bold tracking-tight">
            Crie uma sequência de passos
          </h1>
          <LocalPlan setSteps={setSteps} steps={steps} robotId={robotId} />
        </div>

        <div className="flex justify-end items-start">
          <DeleteLocalPlanButton robotId={robotId} />
        </div>
      </div>
    </>
  );
};

export default LocalPlanPage;
