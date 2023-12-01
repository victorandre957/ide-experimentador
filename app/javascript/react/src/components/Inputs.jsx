import React, { useState } from "react";

const LocalPlanForm = () => {
  const [selectedSkill, setSelectedSkill] = useState("");
  const [formParams, setFormParams] = useState({
    skill: "",
    label: "",
    parameters: {},
  });

  const handleSkillChange = (e) => {
    const skill = e.target.value;
    setSelectedSkill(skill);
    setFormParams({ skill, parameters: {} });
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
      parameters: {
        ...prevParams.parameters,
        [name]: value,
      },
    }));
  };

  const handleWaypointChange = (index, coord, value) => {
    setFormParams((prevParams) => ({
      ...prevParams,
      parameters: {
        ...prevParams.parameters,
        waypoints: prevParams.parameters.waypoints.map((waypoint, i) =>
          i === index ? { ...waypoint, [coord]: value } : waypoint
        ),
      },
    }));
  };

  const handleAddWaypoint = () => {
    setFormParams((prevParams) => ({
      ...prevParams,
      parameters: {
        ...prevParams.parameters,
        waypoints: [
          ...(prevParams.parameters.waypoints || []),
          { x: "", y: "", z: "" },
        ],
      },
    }));
  };

  const handleRemoveWaypoint = () => {
    setFormParams((prevParams) => {
      const waypoints = prevParams.parameters.waypoints || [];
      waypoints.pop(); // Remove the last waypoint
      return {
        ...prevParams,
        parameters: { ...prevParams.parameters, waypoints },
      };
    });
  };

  const handleRemove = () => {
    onRemove(1);
  };

  const renderFormInputs = () => {
    return (
      <div>
        <label htmlFor="labelInput">Label:</label>
        <input
          id="labelInput"
          type="text"
          placeholder="Label"
          onChange={handleLabelChange}
        />
        <label htmlFor="skillSelect">Select Skill:</label>
        <select id="skillSelect" onChange={handleSkillChange}>
          <option value="">Select a skill</option>
          <option value="navigation">Navigation</option>
          <option value="operate_drawer">Operate Drawer</option>
          <option value="approach_person">Approach Person</option>
          <option value="authenticate_person">Authenticate Person</option>
        </select>

        <button onClick={handleRemove}>Deletar etapa</button>

        {renderFormInputsForSkill()}
        <pre>{JSON.stringify(formParams, null, 2)}</pre>
      </div>
    );
  };

  const renderFormInputsForSkill = () => {
    if (selectedSkill === "navigation") {
      return (
        <div>
          <input
            type="text"
            placeholder="Room"
            onChange={(e) => handleInputChange("room", e.target.value)}
          />
          <button onClick={handleAddWaypoint}>Add Waypoint</button>
          <button onClick={handleRemoveWaypoint}>Remove Last Waypoint</button>
          {renderWaypointInputs()}
        </div>
      );
    } else if (
      selectedSkill === "operate_drawer" ||
      selectedSkill === "approach_person" ||
      selectedSkill === "authenticate_person"
    ) {
      const key = selectedSkill === "operate_drawer" ? "action" : "topic";
      return (
        <input
          type="text"
          placeholder={selectedSkill === "operate_drawer" ? "Action" : "Topic"}
          onChange={(e) => handleInputChange(key, e.target.value)}
        />
      );
    }

    return null;
  };

  const renderWaypointInputs = () => {
    if (selectedSkill === "navigation" && formParams.parameters.waypoints) {
      return formParams.parameters.waypoints.map((waypoint, index) => (
        <div key={index}>
          <input
            type="number"
            placeholder="x"
            onChange={(e) => handleWaypointChange(index, "x", e.target.value)}
          />
          <input
            type="number"
            placeholder="y"
            onChange={(e) => handleWaypointChange(index, "y", e.target.value)}
          />
          <input
            type="number"
            placeholder="z"
            onChange={(e) => handleWaypointChange(index, "z", e.target.value)}
          />
        </div>
      ));
    }

    return null;
  };

  return <div>{renderFormInputs()}</div>;
};

export default LocalPlanForm;
