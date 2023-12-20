import axios from "axios";
import { useEffect, useState } from "react";

export function useLocalPlan(robotId) {
  const [steps, setSteps] = useState([]);
  useEffect(() => {
    if (!Number.isNaN(robotId)) {
      axios
        .get(`/api/local_plan_steps/index_by_robot/${robotId}`)
        .then((response) => {
          setSteps(response.data);
        })
        .catch((error) => {
          console.error("Erro ao carregar os passos:", error);
        });
    }
  }, []);

  return [steps, setSteps];
}
