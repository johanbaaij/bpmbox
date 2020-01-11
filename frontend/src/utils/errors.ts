import { AxiosError } from "axios";

export function getErrorMessage(error: AxiosError): string | null {
  if (error.response) {
    return (
      error.response.data.errors[0] ||
      error.response.data.errors.full_messages[0]
    );
  }
  if (error.message) {
    return error.message;
  }
  return null;
}
