import React, { useState } from "react";
import LocalPlanForm from "../components/LocalPlanForm";
import styled from "styled-components";
import axios from "axios";

let existPlan = false;

const CreateLocalPlan = ({ robotId }) => {
  const [steps, setSteps] = useState([]);

  let robotId = 22;

  if (robotId) {
    alert();
    useEffect(() => {
      axios
        .get(`local_plan_steps/index_by_robot/${robotId}`)
        .then((response) => {
          existPlan = !!response.data.local_plan;
          setSteps(response.data.local_plan || []);
        })
        .catch((error) => {
          console.error("Erro ao carregar os passos:", error);
        });
    }, [robotId]);
  }

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
    axios
      .delete(`local_plan_steps/${robotId}`)
      .then((response) => {
        console.log("Plano do robô deletado com sucesso:", response.data);
      })
      .catch((error) => {
        console.error("Erro ao deletar o plano do robô:", error);
      });
    setSteps([]);
  };

  const handleSave = () => {
    const url = existPlan
      ? `/api/local_plan_steps/${robotId}`
      : "/api/local_plan_steps";
    
    let robotId = 22
    
    if (!existPlan) {
      axios
        .post(url, { local_plan: steps, robot_Id: robotId })
        .then((response) => {
          console.log("Passos salvos/atualizados com sucesso:", response.data);
        })
        .catch((error) => {
          console.error("Erro ao salvar/atualizar os passos:", error);
        });
    } else {
      axios
        .update(url, { local_plan: steps, robot_Id: robotId })
        .then((response) => {
          console.log("Passos salvos/atualizados com sucesso:", response.data);
        })
        .catch((error) => {
          console.error("Erro ao salvar/atualizar os passos:", error);
        });
    }
  };

  const TitleDiv = styled.div`
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    padding: 0 1rem;
  `;
  const ContentDiv = styled.div`
    display: grid;
    grid-template-columns: 1fr;
    gap: 1rem;
  `;
  return (
    <div>
      <div>
        <h1>Criar uma sequência de passos</h1>
        <button onClick={handleDeletePlan}>Deletar Plano Local</button>
      </div>
      {steps.map((step, index) => (
        <LocalPlanForm
          key={index} // Adicione a chave única para cada Input
          step={step}
          stepIndex={index}
          onChange={handleChange}
          onRemove={handleRemoveStep}
        />
      ))}
      <button onClick={handleAddStep}>Adicionar Passo</button>
      <button onClick={handleSave}>Salvar</button>
    </div>
  );
};

export default CreateLocalPlan;
