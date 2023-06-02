import Head from 'next/head';
import Image from 'next/image';
import Link from 'next/link';
import Layout from '../components/layout';
import utilStyles from '../styles/utils.module.css';
import { getTracks } from '../lib/get_tracks';
import Tracks from '../components/tracks'
import { useState, useEffect } from 'react';

// export async function getStaticProps() {
//   const allTracksData = await getTracks();
//   console.log(allTracksData);
//   return {
//     props: {
//       allTracksData,
//     },
//   };
// }

export default function TrackLayout({ allTracksData }) {
  const [page, setPage] = useState(1);
  const [isLoading, setIsLoading] = useState(false);
  const [tracksData, setTracksData] = useState([]);

  useEffect(() => { fetchTracks() }, [])
  const fetchTracks = async (page) => {
    setIsLoading(true);
    setTracksData(await getTracks(page));
    setIsLoading(false);
  }

  function handlePage(isNext) {
    const newPage = isNext ? (page + 1) : (page - 1);
    fetchTracks(newPage);
    setPage(newPage);
  }

  return (
    <>
      <Layout tracks>
        <Head>
          <title>Tracks</title>
        </Head>
        <section className={`${utilStyles.headingMd} ${utilStyles.padding1px}`}>
          <h2 className={utilStyles.headingLg}>Tracks</h2>
          <Tracks allTracksData={tracksData} isLoading={isLoading}/>
        </section>
        <button onClick={() => handlePage(false)}>Prev</button>
        <button onClick={() => handlePage(true)}>Next</button>
      </Layout>
    </>
  )
}
