import React, { useEffect, useState } from "react";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
  AlertDialogTrigger,
} from "../components/AlertDialog";
import { useMutation, useQuery } from "@tanstack/react-query";
import { getLocalPlan } from "../api/localPlan/getLocalPlan";
import { deleteLocalPlan } from "../api/localPlan/deleteLocalPlan";

const id = 0;

const Hello = (props) => {
  let [count, setCount] = useState(0);
  const { data, error } = useQuery({
    queryKey: ["local_plan/:id", id],
    queryFn: getLocalPlan,
  });

  const deleteLocalPlanMutation = useMutation({
    mutationFn: deleteLocalPlan,
    onError(err) {
      alert(err.message);
    },
  });

  return (
    <div>
      <h1 className="text-2xl text-indigo-300">
        Counter prop:{props.name}: {count}
      </h1>
      <button
        onClick={() => {
          setCount(count + 1);
        }}
      >
        Next Id
      </button>
      <AlertDialog>
        <AlertDialogTrigger asChild>
          <button className="bg-red-500 px-3 py-2 rounded text-zinc-100 m-2 font-semibold">
            Delete
          </button>
        </AlertDialogTrigger>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Are you absolutely sure?</AlertDialogTitle>
            <AlertDialogDescription>
              This action cannot be undone. This will permanently delete your
              account and remove your data from our servers.
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel>Cancel</AlertDialogCancel>
            <AlertDialogAction
              onClick={() => {
                deleteLocalPlanMutation.mutate(0);
              }}
            >
              Continue
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
      <br />
      data: {JSON.stringify(data)}
      <br />
      error: {error?.message}
    </div>
  );
};

export default Hello;
