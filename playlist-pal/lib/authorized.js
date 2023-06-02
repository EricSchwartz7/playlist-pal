import { useRouter } from 'next/router';

export async function authorized(code, state) {

  const res = await fetch(`http://localhost:3000/api/v1/users/authorized?code=${code}&state=${state}`);
  const response = await res.json();
  return response;
}
