import Head from 'next/head';
import Link from 'next/link';
import Layout from '../components/layout';
import utilStyles from '../styles/utils.module.css';
import { getTracks } from '../lib/tracks';

export async function getStaticProps() {
  const allTracksData = await getTracks();
  console.log(allTracksData);
  return {
    props: {
      allTracksData,
    },
  };
}

export default function Tracks({ allTracksData }) {
  return (
    <>
      <Layout tracks>
        <Head>
          <title>Tracks</title>
        </Head>
        <section className={`${utilStyles.headingMd} ${utilStyles.padding1px}`}>
        <h2 className={utilStyles.headingLg}>Tracks</h2>
        <ul className={utilStyles.list}>
          {allTracksData.map(({ foo, id }) => (
            <li className={utilStyles.listItem} key={id}>
              {foo}
            </li>
          ))}
        </ul>
      </section>
      </Layout>
    </>
  )
}
