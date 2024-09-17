import React from 'react';
import logo from './logo.svg';
import './App.css';
import axios from 'axios';

function App() {
  const navigateToGrafana = async () => {
    try {
      // API Gatewayのエンドポイントを指定
      const apiEndpoint = " https://3br5dacarg.execute-api.ap-northeast-1.amazonaws.com/apis/dev_set_cookie";
      
      // Lambda関数を呼び出して、クッキーを設定
      const response = await axios.post(apiEndpoint, {
        withCredentials: true  // クッキーを処理するために必要
      });

      if (response.status === 200) {
        console.log("Response from Lambda:", response.data);

        // クッキーが正常に設定された後、Grafanaにリダイレクト、別タブで開く
        window.open("https://v2023-9.test.iip.chuden.jp/", "_blank");
      } else {
        console.error("Failed to set cookie via Lambda:", response.statusText);
      }
    } catch (error) {
      console.error("Error setting cookie:", error);
    }
  };

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.tsx</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
        <button onClick={navigateToGrafana}>Navigate to Grafana</button>
      </header>
    </div>
  );
}

export default App;
