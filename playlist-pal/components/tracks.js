import utilStyles from '../styles/utils.module.css';

export default function Tracks({ allTracksData, isLoading }) {
  return (
    <div className={utilStyles.tableContainer}>
      {isLoading ? "Loading..." :
        <table class='table-auto'>
          <thead>
            <tr>
              <th>Artist</th>
              <th>Title</th>
              <th>Album</th>
            </tr>
          </thead>
          <tbody>
            {allTracksData.map(({ track }) => (
              <tr className={utilStyles.listItem} key={track.id}>
                <td>{track.artists.map((artist) => `${artist.name}\n`)}</td>
                <td>{track.name}</td>
                <td>{track.album.name}</td>
              </tr>
            ))}
          </tbody>
        </table>
      }
    </div>
  )
}
