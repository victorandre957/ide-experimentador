import React, { useState } from "react";
import LocalPlanForm from "../components/LocalPlanForm";
import styled from "styled-components";

let steps = [
  {
    skill: "",
    label: "",
    parameter: {},
  },
];

const CreatLocalPlan = () => {
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
    forceUpdate(); 
  };

  // Função para forçar a atualização do componente
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
      <button onClick={() => {console.log(steps)}}>Salvar</button>
      <button onClick={handleAddStep}>Adicionar Passo</button>
    </ContentDiv>
  );
};

export default CreatLocalPlan;
