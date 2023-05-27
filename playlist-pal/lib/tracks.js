// const postsDirectory = path.join(process.cwd(), 'posts');

export async function getTracks() {

  // return [{
  //   foo: 'bar',
  //   id: 1
  // }]

  const res = await fetch('http://localhost:3000/api/v1/tracks/hump_tracks');
  const trackData = await res.json();

  return trackData.items;


  // Sort posts by date
  // return tracksData.sort((a, b) => {
  //   if (a.date < b.date) {
  //     return 1;
  //   } else {
  //     return -1;
  //   }
  // });
}
