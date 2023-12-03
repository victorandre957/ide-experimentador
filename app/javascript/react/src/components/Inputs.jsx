import React, { useState } from "react";
import styled from "styled-components";

const LocalPlanForm = () => {
  const [selectedSkill, setSelectedSkill] = useState("");
  const [formParams, setFormParams] = useState({
    skill: "",
    label: "",
    parameter: {},
  });

  const handleSkillChange = (e) => {
    const skill = e.target.value;
    setSelectedSkill(skill);
    setFormParams({ skill, parameter: {} });
  };

  const handleActionChange = (e) => {
    const action = e.target.value;
    setFormParams((prevParams) => ({
      ...prevParams,
      parameter: {
        ...prevParams.parameter,
        action: action,
      },
    }));
  };

  const handleLabelChange = (e) => {
    setFormParams((prevParams) => ({
      ...prevParams,
      label: e.target.value,
    }));
  };

  const handleInputChange = (name, value) => {
    setFormParams((prevParams) => ({
      ...prevParams,
      parameter: {
        ...prevParams.parameter,
        [name]: value,
      },
    }));
  };

  const handleWaypointChange = (index, coord, value) => {
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
    onRemove(1);
  };

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
          onChange={handleLabelChange}
        />
        <label htmlFor="skillSelect">Selecione uma habilidade:</label>
        <select
          id="skillSelect"
          style={{ borderRadius: "6px", padding: "8px" }}
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
        <pre>{JSON.stringify(formParams, null, 2)}</pre>
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
              style={{ borderRadius: "6px", padding: "8px" }}
              type="text"
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
              style={{ borderRadius: "6px", padding: "8px" }}
              onChange={handleActionChange}
            >
              <option value="">Ação</option>
              <option value="open">Abrir</option>
              <option value="close">Fechar</option>
            </select>
          </NavDiv>
        </ParameterDiv>
      );
    }

    return null;
  };

  const renderWaypointInputs = () => {
    if (selectedSkill === "navigation" && formParams.parameter.waypoints) {
      return formParams.parameter.waypoints.map((waypoint, index) => (
        <div key={index}>
          <WaypointsContentDiv>
            <WaypointDiv>
              <input
                style={{
                  borderRadius: "6px",
                  padding: "8px",
                }}
                type="number"
                placeholder="x"
                onChange={(e) =>
                  handleWaypointChange(index, "x", e.target.value)
                }
              />
            </WaypointDiv>
            <WaypointDiv>
              <input
                style={{ borderRadius: "6px", padding: "8px" }}
                type="number"
                placeholder="y"
                onChange={(e) =>
                  handleWaypointChange(index, "y", e.target.value)
                }
              />
            </WaypointDiv>
            <WaypointDiv>
              <input
                style={{
                  borderRadius: "6px",
                  padding: "8px",
                }}
                type="number"
                placeholder="z"
                onChange={(e) =>
                  handleWaypointChange(index, "z", e.target.value)
                }
              />
            </WaypointDiv>
          </WaypointsContentDiv>
        </div>
      ));
    }

    return null;
  };

  return <div>{renderFormInputs()}</div>;
};

export default LocalPlanForm;
