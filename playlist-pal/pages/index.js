import Head from 'next/head';
import Layout, { siteTitle } from '../components/layout';
import utilStyles from '../styles/utils.module.css';
import Link from 'next/link';

export default function Home() {
  return (
    <Layout home>
      <Head>
        <title>{siteTitle}</title>
      </Head>
      <section className={utilStyles.headingMd}>
        <p>Welcome to Playlist Pal</p>
        <h2>
          <Link href="/track_layout">Tracks</Link>
        </h2>
      </section>
    </Layout>
  );
}
