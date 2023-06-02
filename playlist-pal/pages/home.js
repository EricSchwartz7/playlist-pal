import Head from 'next/head';
import Layout, { siteTitle } from '../components/layout';
import utilStyles from '../styles/utils.module.css';
import Link from 'next/link'
import { useState, useEffect } from 'react';
import { useRouter } from 'next/router';
import { authorized } from '../lib/authorized'

export default function Home() {
  const [isAuthorized, setIsAuthorized] = useState(false);
  const [isLoading, setIsLoading] = useState(false);

  const authorizing = async () => {
    setIsLoading(true);
    const urlParams = new URLSearchParams(window.location.search);
    const response = await authorized(urlParams.get('code'), urlParams.get('state'))
    localStorage.setItem('user', response?.user?.id);
    setIsAuthorized(!!response?.user?.access_token);
    setIsLoading(false);
  }

  useEffect(() => { authorizing() }, [])


  return (
    <Layout home>
      <Head>
        <title>{siteTitle}</title>
      </Head>
      <section className={utilStyles.headingMd}>
        {isLoading ? 'loading...' :
          <>
            {isAuthorized ? <>
                <p>Welcome to Playlist Pal</p>
                <h2><Link href="/track_layout">Tracks</Link></h2>
              </> : <h2><Link href="http://localhost:3000/api/v1/users/authorize_me">Log In (again)</Link></h2>
            }
          </>
        }
      </section>
    </Layout>
  );
}
