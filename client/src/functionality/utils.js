export async function queryExchange(queryPassed) {
  const response = await fetch("/api/query", {
    method: "POST",
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      query: queryPassed,
    }),
  }).catch((error) => {
    console.log(error);
  });
  const json = await response.json();
  return json;
}
