export async function getTracks(page) {
  const userId = localStorage.getItem('user');
  const res = await fetch(`http://localhost:3000/api/v1/tracks/hump_tracks?page=${page || 1}&user=${userId}`);
  const trackData = await res.json();

  return trackData.items;
}
