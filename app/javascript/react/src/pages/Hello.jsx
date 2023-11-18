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

const Hello = (props) => {
  let [count, setCount] = useState(0);

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
        {" "}
        Add{" "}
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
                alert("deletando suas parada");
              }}
            >
              Continue
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </div>
  );
};

export default Hello;
