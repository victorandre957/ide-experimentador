import React, { useState } from "react";
import LocalPlanForm from "../components/LocalPlanForm";
import styled from "styled-components";
import axios from "axios";

let steps = [];
let existPlan = false;

const CreateLocalPlan = ({ robotId }) => {

  if (robotId) {
    useEffect(() => {
      axios.get(`local_plan_steps/index_by_robot/${robotId}`)
        .then((response) => {
          existPlan = !!response.data.local_plan;
          steps = (response.data.local_plan || []);
        })
        .catch((error) => {
          console.error("Erro ao carregar os passos:", error);
        });
    }, [robotId]);
  }

  const handleChange = (index, value) => {
    const newSteps = [...steps];
    newSteps[index] = value;
    steps = [...newSteps];
  };

  const handleAddStep = () => {
    steps = [...steps, { skill: "", label: "", parameter: {} }];
    forceUpdate(); 
  };

  const handleRemoveStep = (index) => {
    const newSteps = steps.filter((_, i) => i !== index);
    steps = [...newSteps];
    forceUpdate(); 
  };

  const handleDeletePlan = () => {
    steps = [];
      axios.delete(`local_plan_steps/${robotId}`)
      .then((response) => {
        console.log("Plano do robô deletado com sucesso:", response.data);
      })
      .catch((error) => {
        console.error("Erro ao deletar o plano do robô:", error);
      });
    forceUpdate(); 
  };

  const handleSave = () => {
    forceUpdate(); 
    const url = existPlan ? `local_plan_steps/${robotId}` : 'local_plan_steps';

    if (!existPlan) {
      axios.create(url, { local_plan: steps })
        .then((response) => {
          console.log("Passos salvos/atualizados com sucesso:", response.data);
        })
        .catch((error) => {
          console.error("Erro ao salvar/atualizar os passos:", error);
        });
    } else {
      axios.update(url, { local_plan: steps })
        .then((response) => {
          console.log("Passos salvos/atualizados com sucesso:", response.data);
        })
        .catch((error) => {
          console.error("Erro ao salvar/atualizar os passos:", error);
        });
    }
  };

  const [, updateState] = useState();
  const forceUpdate = () => updateState({});

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
    <ContentDiv>
      <TitleDiv>
        <h1>Criar uma sequência de passos</h1>
        <button onClick={handleDeletePlan}>Deletar Plano Local</button>
      </TitleDiv>
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
    </ContentDiv>
  );
};

export default CreateLocalPlan;
