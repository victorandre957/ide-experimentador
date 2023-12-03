import React, { useState, useEffect } from "react";
import styled from "styled-components";

const StepDiv = styled.div`
display: flex;
flex-direction: column;
gap: 0.5rem;
width: 100%;
padding: 2rem;
width: 50%;
`;

const ParameterDiv = styled.div`
margin-left: 2rem;
margin-top: 0.5rem;
display: flex;
flex-direction: column;
border-left: 2px solid black;
padding-left: 0.5rem;
padding-top: 0.5rem;
gap: 1rem;
items-align: start;
`;

const TitleParameterDiv = styled.div`
color: #808080;
`;

const RoomDiv = styled.div`
display: flex;
justify-content: space-between;
gap: 3rem;
align-items: center;
width: 50%;
`;

const RoomContentDiv = styled.div`
display: flex;
flex-direction: column;
gap: 0.5rem;
`;

const NavDiv = styled.div`
display: flex;
flex-direction: column;
gap: 1rem;
margin-left: 2rem;
padding-bottom: 1rem;
`;

const WaypointsContentDiv = styled.div`
display: flex;
flex-direction: column;
margin-left: 2rem;
width: 60%;
gap: 0.5rem;
`;

const WaypointsDiv = styled.div`
display: flex;
flex-direction: column;
gap: 2rem;
`;

const WaypointDiv = styled.div`
width: 100%;
`;

const LocalPlanForm = ({ step, stepIndex, onRemove, onChange }) => {
  const [selectedSkill, setSelectedSkill] = useState("");
  const [formParams, setFormParams] = useState({
    skill: "",
    label: "",
    parameter: {},
  });

  useEffect(() => {
    setFormParams(step);
    setSelectedSkill(step.skill);
  }, [step]);

  const handleSkillChange = (e) => {
    const _skill = e.target.value;
    const updatedParams = { ...formParams, skill: _skill, parameter: {} };
    if(_skill === "navigation") {
      updatedParams.parameter = { room: "", waypoints: [] };
    }
    onChange(stepIndex, updatedParams);
    setSelectedSkill(_skill);
    setFormParams(updatedParams);
  };

  const handleActionChange = (e) => {
    const action = e.target.value;
    onChange(stepIndex, {
      ...formParams,
      parameter: {
        ...formParams.parameter,
        action: action,
      },
    });
    setFormParams((prevParams) => ({
      ...prevParams,
      parameter: {
        ...prevParams.parameter,
        action: action,
      },
    }));
  };

  const handleLabelChange = (e) => {
    const { value } = e.target;
    onChange(stepIndex, { ...formParams, label: value });
    setFormParams((prevParams) => ({
      ...prevParams,
      label: value,
    }));
  };

  const handleInputChange = (name, value) => {
    onChange(stepIndex, {
      ...formParams,
      parameter: {
        ...formParams.parameter,
        [name]: value,
      },
    });
    setFormParams((prevParams) => ({
      ...prevParams,
      parameter: {
        ...prevParams.parameter,
        [name]: value,
      },
    }));
  };

  const handleWaypointChange = (index, coord, value) => {
    onChange(stepIndex, {
      ...formParams,
      parameter: {
        ...formParams.parameter,
        waypoints: formParams.parameter.waypoints.map((waypoint, i) =>
          i === index ? { ...waypoint, [coord]: value } : waypoint
        ),
      },
    });
    setFormParams((prevParams) => ({
      ...prevParams,
      parameter: {
        ...prevParams.parameter,
        waypoints: prevParams.parameter.waypoints.map((waypoint, i) =>
          i === index ? { ...waypoint, [coord]: value } : waypoint
        ),
      },
    }));
  };

  const handleAddWaypoint = () => {
    onChange(stepIndex, {
      ...formParams,
      parameter: {
        ...formParams.parameter,
        waypoints: [
          ...(formParams.parameter.waypoints || []),
          { x: "", y: "", z: "" },
        ],
      },
    });
    setFormParams((prevParams) => ({
      ...prevParams,
      parameter: {
        ...prevParams.parameter,
        waypoints: [
          ...(prevParams.parameter.waypoints || []),
          { x: "", y: "", z: "" },
        ],
      },
    }));
  };

  const handleRemoveWaypoint = () => {
    onChange(stepIndex, {
      ...formParams,
      parameter: {
        ...formParams.parameter,
        waypoints: formParams.parameter.waypoints.slice(0, -1),
      },
    });
    setFormParams((prevParams) => {
      const waypoints = prevParams.parameter.waypoints || [];
      waypoints.pop(); // Remove the last waypoint
      return {
        ...prevParams,
        parameter: { ...prevParams.parameter, waypoints },
      };
    });
  };

  const handleRemove = () => {
    onRemove(stepIndex);
  };

  const renderFormInputs = () => {
    return (
      <StepDiv>
        <button onClick={handleRemove}>Deletar passo</button>
        <label htmlFor="labelInput">Nome da passo:</label>
        <input
          style={{ borderRadius: "6px", padding: "8px" }}
          id="labelInput"
          type="text"
          placeholder="Nome"
          value={formParams.label || ""}
          onChange={handleLabelChange}
        />
        <label htmlFor="skillSelect">Selecione uma habilidade:</label>
        <select
          id="skillSelect"
          style={{ borderRadius: "6px", padding: "8px" }}
          value={formParams.skill || ""}
          onChange={handleSkillChange}
        >
          <option value="">Habilidade</option>
          <option value="navigation">Navegação</option>
          <option value="operate_drawer">Operar gaveta</option>
          <option value="approach_person">Aproximar-se de uma pessoa</option>
          <option value="approach_robot">Aproximar-se de um robo</option>
          <option value="authenticate_person">Autentificar pessoa</option>
        </select>
        {renderFormInputsForSkill()}
      </StepDiv>
    );
  };

  const renderFormInputsForSkill = () => {
    if (selectedSkill === "navigation") {
      return (
        <ParameterDiv>
          <TitleParameterDiv>
            <span>Parâmetros da habilidade</span>
          </TitleParameterDiv>

          <NavDiv>
            <RoomDiv>
              <RoomContentDiv>
                <span>Local de objetivo</span>
                <input
                  style={{ borderRadius: "6px", padding: "8px" }}
                  type="text"
                  placeholder="Sala"
                  onChange={(e) => handleInputChange("room", e.target.value)}
                  value={formParams.parameter.room || ""}
                />
              </RoomContentDiv>
              <button onClick={handleAddWaypoint}>Adicionar waypoint</button>
            </RoomDiv>
            <span>Passos para chegar lá</span>
            <WaypointsDiv>{renderWaypointInputs()}</WaypointsDiv>
            <button onClick={handleRemoveWaypoint}>
              Remover último waypoint
            </button>
          </NavDiv>
        </ParameterDiv>
      );
    } else if (
      selectedSkill === "approach_person" ||
      selectedSkill === "approach_robot" ||
      selectedSkill === "authenticate_person"
    ) {
      const key = selectedSkill === "operate_drawer" ? "action" : "topic";
      return (
        <ParameterDiv>
          <TitleParameterDiv>
            <span>Parâmetros da habilidade</span>
          </TitleParameterDiv>

          <NavDiv>
            <input
              style={{ borderRadius: "0.375rem", padding: "0.5rem" }}
              type="text"
              value={formParams.parameter[key] || ""}
              placeholder={"Tópico"}
              onChange={(e) => handleInputChange(key, e.target.value)}
            />
          </NavDiv>
        </ParameterDiv>
      );
    } else if ("operate_drawer" === selectedSkill) {
      return (
        <ParameterDiv>
          <TitleParameterDiv>
            <span>Parâmetros da habilidade</span>
          </TitleParameterDiv>

          <NavDiv>
            <select
              id="operate_drawer"
              style={{ borderRadius: "0.375rem", padding: "0.5rem" }}
              onChange={handleActionChange}
              value={formParams.parameter[key] || ""}
            >
              <option value="">Ação</option>
              <option value="open">Abrir</option>
              <option value="close">Fechar</option>
            </select>
          </NavDiv>
        </ParameterDiv>
      );
    }
  };

  const renderWaypointInputs = () => {
    if (selectedSkill === "navigation" && formParams.parameter.waypoints) {
      return formParams.parameter.waypoints.map((waypoint, index) => (
        <div key={index}>
          <WaypointsContentDiv>
            <WaypointDiv>
              <input
                style={{
                  borderRadius: "0.375rem",
                  padding: "0.5rem",
                }}
                value={waypoint.x || ""}
                type="number"
                placeholder="x"
                onChange={(e) =>
                  handleWaypointChange(index, "x", e.target.value)
                }
              />
            </WaypointDiv>
            <WaypointDiv>
              <input
                style={{ borderRadius: "0.375rem", padding: "0.5rem" }}
                type="number"
                placeholder="y"
                value={waypoint.y || ""}
                onChange={(e) =>
                  handleWaypointChange(index, "y", e.target.value)
                }
              />
            </WaypointDiv>
            <WaypointDiv>
              <input
                style={{
                  borderRadius: "0.375rem",
                  padding: "0.5rem",
                }}
                type="number"
                placeholder="z"
                value={waypoint.z || ""}
                onChange={(e) =>
                  handleWaypointChange(index, "z", e.target.value)
                }
              />
            </WaypointDiv>
          </WaypointsContentDiv>
        </div>
      ));
    }
  };

  return <div>{renderFormInputs()}</div>;
};

export default LocalPlanForm;
