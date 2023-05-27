import Head from 'next/head';
import Image from 'next/image';
import Link from 'next/link';
import Layout from '../components/layout';
import utilStyles from '../styles/utils.module.css';
import { getTracks } from '../lib/tracks';
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
  const [tracksData, setTracksData] = useState([]);
  useEffect(() => { url()  }, [])
  const url = async () => {
    setTracksData(await getTracks());
  }

  return (
    <>
      <Layout tracks>
        <Head>
          <title>Tracks</title>
        </Head>
        <section className={`${utilStyles.headingMd} ${utilStyles.padding1px}`}>
        <h2 className={utilStyles.headingLg}>Tracks</h2>
        <Tracks allTracksData={tracksData}/>
      </section>
      </Layout>
    </>
  )
}
