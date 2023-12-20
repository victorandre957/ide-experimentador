import { Toaster } from "react-hot-toast";

export function StyledToaster() {
  return (
    <Toaster
      toastOptions={{
        success: {
          className: "bg-green-100 p-5 rounded",
          icon: (
            <span className="flex">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="round"
                className="text-green-500"
              >
                <path d="M20 6 9 17l-5-5" />
              </svg>
              Sucesso
            </span>
          ),
        },
        error: {
          className: "bg-red-100 p-5 rounded",
          icon: (
            <span className="flex">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="round"
                className="text-red-500"
              >
                <path d="M18 6 6 18" />
                <path d="m6 6 12 12" />
              </svg>
              Algo deu errado
            </span>
          ),
        },
      }}
    />
  );
}
