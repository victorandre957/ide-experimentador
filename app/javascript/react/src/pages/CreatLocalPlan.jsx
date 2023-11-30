import React, { useState } from 'react';
import Inputs from '../components/Inputs';
import styled from 'styled-components';

const App = () => {
  const [steps, setSteps] = useState([{ skill: '', parameters: '', goal: '' }]);

  const handleChange = (index, name, value) => {
      const newSteps = [...steps];
      newSteps[index][name] = value;
      setSteps(newSteps);
  };

  const handleAddStep = () => {
      setSteps([...steps, { skill: '', parameters: '', goal: '' }]);
  };

  const handleRemoveStep = (index) => {
      const newSteps = steps.filter((_, i) => i !== index);
      setSteps(newSteps);
  };

  const handleDeletePlan = (index) => {
    setSteps([])
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
    <ContentDiv>
      <TitleDiv>
        <h1>Criar uma sequência de passos</h1>
        <button onClick={handleDeletePlan}>Deletar Plano Local</button>
      </TitleDiv>
      {steps.map((step, index) => (
        <Inputs key={index} params={step} index={index} onChange={handleChange} onRemove={handleRemoveStep} />
      ))}
      <button onClick={handleAddStep}>Adicionar Passo</button>
    </ContentDiv>
  );
};

export default App;