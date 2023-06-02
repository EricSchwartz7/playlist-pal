import Head from 'next/head';
import Layout, { siteTitle } from '../components/layout';
import utilStyles from '../styles/utils.module.css';
import Link from 'next/link';

export default function LogIn() {
  return (
    <Layout home>
      <Head>
        <title>{siteTitle}</title>
      </Head>
      <section className={utilStyles.headingMd}>
        <h2>
          <Link href="http://localhost:3000/api/v1/users/authorize_me">Log In</Link>
        </h2>
      </section>
    </Layout>
  );
}
