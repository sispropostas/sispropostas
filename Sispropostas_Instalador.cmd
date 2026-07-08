<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<script>
  // ============================================================
  // VERSAO DESTA PAGINA - EDITE APENAS ESTE VALOR NO GITHUB
  // Fica aqui, no topo do arquivo, para ser facil de localizar.
  // Esta mesma variavel e usada mais abaixo no script principal.
  // ============================================================
  const versao = "1.1";
</script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SISpropostas</title>
<link rel="icon" type="image/x-icon" href="https://raw.githubusercontent.com/sispropostas/sispropostas/main/Sispropostas.ico">
<style>
  :root {
    --verde-escuro: #0F3325;
    --verde-escuro-2: #082017;
    --verde-tile: #163A2E;
    --verde-medio: #1E5540;
    --verde-linha: #26463A;
    --folha: #3E9B36;
    --folha-clara: #56B84A;
    --ambar: #E0A83B;
    --fundo: #F4F6F4;
    --branco: #FFFFFF;
    --texto: #1C2321;
    --texto-suave: #5A645F;
    --sidebar-suave: #B9CFC4;
    --sidebar-titulo: #EAF3EE;
    --borda: #E2E6E1;
  }

  * { box-sizing: border-box; margin: 0; padding: 0; }

  html, body {
    height: 100%;
    font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
    background: var(--fundo);
    color: var(--texto);
  }

  body { display: flex; flex-direction: column; height: 100vh; overflow: hidden; }

  /* ===== Faixa de aviso de versao desatualizada ===== */
  .aviso-desatualizado {
    display: none;
    background: #8A2020;
    color: #fff;
    text-align: center;
    padding: 10px 16px;
    font-size: 0.86rem;
    font-weight: 600;
    flex-shrink: 0;
  }
  .aviso-desatualizado button {
    color: #fff;
    text-decoration: underline;
    background: none;
    border: none;
    font-weight: 700;
    cursor: pointer;
    font-size: 0.86rem;
    margin-left: 6px;
  }

  /* ===== Layout principal 30 / 70 ===== */
  .layout { flex: 1; display: flex; min-height: 0; }

  /* ===== Menu lateral (30%) ===== */
  .sidebar {
    width: 35%;
    min-width: 330px;
    max-width: 480px;
    background: linear-gradient(180deg, var(--verde-escuro) 0%, var(--verde-escuro-2) 100%);
    color: #fff;
    display: flex;
    flex-direction: column;
    padding: 28px 26px;
    overflow-y: auto;
  }

  .marca {
    display: flex;
    align-items: center;
    gap: 14px;
    padding-bottom: 20px;
    border-bottom: 1px solid var(--verde-linha);
  }
  .marca img {
    width: 52px;
    height: 52px;
    border-radius: 12px;
    display: block;
  }
  .marca .titulo h1 {
    font-size: 1.2rem;
    font-weight: 700;
    color: var(--sidebar-titulo);
    letter-spacing: 0.2px;
  }
  .marca .titulo span {
    display: block;
    font-size: 0.74rem;
    color: var(--sidebar-suave);
    margin-top: 3px;
    line-height: 1.35;
  }

  /* Botao do tutorial (primeiro acesso) */
  .btn-tutorial {
    width: 100%;
    margin-top: 20px;
    flex-wrap: wrap;
    white-space: normal;
    background: transparent;
    color: var(--sidebar-titulo);
    border: 1px dashed var(--folha);
    border-radius: 8px;
    padding: 11px 14px;
    font-size: 0.85rem;
    font-weight: 600;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    transition: background 0.15s ease;
    text-align: center;
    line-height: 1.35;
  }
  .btn-tutorial:hover { background: rgba(62,155,54,0.14); }

  .secao { margin-top: 26px; }
  .secao-titulo {
    font-size: 0.68rem;
    font-weight: 700;
    letter-spacing: 1.2px;
    text-transform: uppercase;
    color: var(--folha-clara);
    margin-bottom: 12px;
  }

  /* ===== Cartoes de aviso / informativos ===== */
  .aviso {
    background: rgba(255,255,255,0.05);
    border: 1px solid var(--verde-linha);
    border-left: 4px solid var(--folha);
    border-radius: 8px;
    padding: 15px 17px;
    margin-bottom: 14px;
  }
  .aviso.atencao { border-left-color: var(--ambar); }
  .aviso.urgente { border-left-color: #D75B5B; }

  .aviso .tag {
    display: inline-block;
    font-size: 0.62rem;
    font-weight: 700;
    letter-spacing: 0.8px;
    text-transform: uppercase;
    color: var(--folha-clara);
    margin-bottom: 5px;
  }
  .aviso.atencao .tag { color: var(--ambar); }
  .aviso.urgente .tag { color: #E88A8A; }

  .aviso h3 {
    font-size: 0.86rem;
    color: var(--sidebar-titulo);
    font-weight: 700;
    margin-bottom: 4px;
  }
  .aviso p {
    font-size: 0.81rem;
    color: #D4E2DA;
    line-height: 1.5;
  }

  /* Rodape da sidebar: status, versao, atualizar */
  .sidebar-rodape {
    margin-top: auto;
    padding-top: 20px;
    border-top: 1px solid var(--verde-linha);
  }

  .status {
    display: flex;
    align-items: center;
    font-size: 0.82rem;
    color: #D4E2DA;
    margin-bottom: 14px;
  }
  .status .bolinha {
    width: 10px;
    height: 10px;
    border-radius: 50%;
    background: #9AA6A0;
    transition: background 0.3s ease, box-shadow 0.3s ease;
    flex-shrink: 0;
    margin-right: 9px;
  }
  .status.online .bolinha { background: #46C46A; box-shadow: 0 0 0 3px rgba(70,196,106,0.22); }
  .status.conectando .bolinha { background: #E0A83B; box-shadow: 0 0 0 3px rgba(224,168,59,0.22); }
  .status.offline .bolinha { background: #D75B5B; box-shadow: 0 0 0 3px rgba(215,91,91,0.22); }

  .linha-versao {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 12px;
  }
  .linha-versao .rotulo { font-size: 0.76rem; color: var(--sidebar-suave); }
  .linha-versao .valor {
    font-size: 0.76rem;
    font-weight: 700;
    color: #fff;
    background: var(--verde-medio);
    padding: 3px 10px;
    border-radius: 20px;
  }

  .sidebar-creditos {
    margin-top: 16px;
    font-size: 0.68rem;
    color: #7E9488;
    text-align: center;
    line-height: 1.5;
  }

  /* ===== Area do chat (70%) ===== */
  .chat-area {
    flex: 1;
    display: flex;
    flex-direction: column;
    min-width: 0;
    background: var(--fundo);
  }

  .chat-topo {
    background: var(--branco);
    border-bottom: 1px solid var(--borda);
    padding: 16px 26px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 16px;
    flex-shrink: 0;
  }
  .chat-topo .esq h2 {
    font-size: 1.05rem;
    color: var(--verde-escuro);
    font-weight: 700;
  }
  .chat-topo .esq p {
    font-size: 0.8rem;
    color: var(--texto-suave);
    margin-top: 2px;
  }
  .chat-topo .status-topo {
    display: flex;
    align-items: center;
    font-size: 0.82rem;
    color: var(--texto-suave);
    white-space: nowrap;
  }
  .chat-topo .status-topo .bolinha {
    width: 9px; height: 9px; border-radius: 50%;
    background: #9AA6A0; transition: background 0.3s ease;
    margin-right: 8px; flex-shrink: 0;
  }
  .chat-topo .status-topo.online .bolinha { background: #46C46A; box-shadow: 0 0 0 3px rgba(70,196,106,0.18); }
  .chat-topo .status-topo.conectando .bolinha { background: #E0A83B; box-shadow: 0 0 0 3px rgba(224,168,59,0.18); }
  .chat-topo .status-topo.offline .bolinha { background: #D75B5B; box-shadow: 0 0 0 3px rgba(215,91,91,0.18); }

  .chat-corpo {
    flex: 1;
    min-height: 0;
    position: relative;
    display: flex;
  }

  #webchat { flex: 1; min-height: 0; width: 100%; }

  .chat-carregando {
    position: absolute;
    inset: 0;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    background: var(--fundo);
    z-index: 5;
    text-align: center;
    padding: 20px;
  }
  .chat-carregando .spinner {
    width: 38px;
    height: 38px;
    border: 4px solid #DCE4DE;
    border-top-color: var(--verde-escuro);
    border-radius: 50%;
    animation: girar 0.9s linear infinite;
    margin-bottom: 16px;
  }
  .chat-carregando.erro .spinner { display: none; }
  .chat-carregando p {
    font-size: 0.9rem;
    color: var(--texto-suave);
    max-width: 420px;
    line-height: 1.5;
  }
  @keyframes girar { to { transform: rotate(360deg); } }

  /* =====================================================================
     BOTOES DE ANEXAR E ENVIAR DO WEB CHAT (+20% de tamanho, verde do banco)
     ATENCAO: o Web Chat da Microsoft nao expõe "tamanho do icone" como
     opcao oficial (styleOptions só controla cor). Este bloco mira nas
     classes internas do componente (sujeitas a mudar em atualizações do
     script, já que carregamos a versão "latest"). Por isso, uso também
     seletores por aria-label como reforço redundante. Se um dia os
     botões voltarem ao tamanho padrão após uma atualização do Web Chat,
     é sinal de que a Microsoft mudou os nomes de classe internos.
     ===================================================================== */
  #webchat .webchat__icon-button,
  #webchat button[aria-label="Enviar"],
  #webchat button[aria-label="Send"],
  #webchat button[aria-label="Carregar arquivo"],
  #webchat button[aria-label="Anexar arquivo"],
  #webchat button[aria-label="Upload file"] {
    width: 48px !important;   /* padrao ~40px + 20% */
    height: 48px !important;  /* padrao ~40px + 20% */
  }

  #webchat .webchat__icon-button svg,
  #webchat button[aria-label="Enviar"] svg,
  #webchat button[aria-label="Send"] svg,
  #webchat button[aria-label="Carregar arquivo"] svg,
  #webchat button[aria-label="Anexar arquivo"] svg,
  #webchat button[aria-label="Upload file"] svg {
    width: 28.8px !important; /* padrao ~24px + 20% */
    height: 28.8px !important;
  }

  #webchat .webchat__icon-button svg *,
  #webchat button[aria-label="Enviar"] svg *,
  #webchat button[aria-label="Send"] svg *,
  #webchat button[aria-label="Carregar arquivo"] svg *,
  #webchat button[aria-label="Anexar arquivo"] svg *,
  #webchat button[aria-label="Upload file"] svg * {
    fill: var(--verde-escuro) !important;
  }

  #webchat .webchat__icon-button:hover svg *,
  #webchat button[aria-label="Enviar"]:hover svg *,
  #webchat button[aria-label="Send"]:hover svg *,
  #webchat button[aria-label="Carregar arquivo"]:hover svg *,
  #webchat button[aria-label="Anexar arquivo"]:hover svg *,
  #webchat button[aria-label="Upload file"]:hover svg * {
    fill: var(--folha) !important;
  }

  /* ===== Responsivo ===== */
  @media (max-width: 820px) {
    body { overflow: auto; height: auto; min-height: 100vh; }
    .layout { flex-direction: column; }
    .sidebar {
      width: 100%;
      max-width: none;
      min-width: 0;
    }
    .chat-area { min-height: 70vh; }
    #webchat { min-height: 65vh; }
  }
</style>
</head>
<body>

<!-- Aviso exibido apenas quando a versao local for menor que a do GitHub -->
<div id="avisoDesatualizado" class="aviso-desatualizado">
  &#9888; Está disponível uma nova versão do Sispropostas.
  <button onclick="atualizarSispropostas()">Clique aqui para atualizar</button> Para a versão <span id="versaoGithubTexto"></span>
</div>

<div class="layout">

  <!-- ================= MENU LATERAL (30%) ================= -->
  <aside class="sidebar">
    <div class="marca">
      <img src="https://raw.githubusercontent.com/sispropostas/sispropostas/main/Sispropostas.ico" alt="Banco da Amazônia">
      <div class="titulo">
        <h1>SISpropostas</h1>
        <span>Registro inteligente de propostas de crédito rural</span>
      </div>
    </div>

    <!-- Botao para quem acessa pela primeira vez -->
    <button class="btn-tutorial" onclick="abrirTutorial()">
      &#128218; Primeira vez aqui? Veja o tutorial
    </button>

    <!-- =====================================================
         AVISOS E INFORMATIVOS
         Para editar: altere, remova ou duplique os blocos
         <div class="aviso"> abaixo (sempre no GitHub) e mude
         o valor da variavel "versao" no script para que as
         assistências recebam o alerta de atualização.
         Tipos disponíveis:
           <div class="aviso">           borda verde  (informativo)
           <div class="aviso atencao">   borda âmbar  (atenção)
           <div class="aviso urgente">   borda vermelha (urgente)
         ===================================================== -->
    <div class="secao">
      <div class="secao-titulo">Avisos e informações</div>

      <div class="aviso">
        <span class="tag">Novidade</span>
        <h3>Nova forma de envio</h3>
        <p>O formulário eletrônico foi substituído por este agente de IA. Registre a proposta e envie os documentos diretamente pela conversa ao lado — a validação e a organização dos arquivos acontecem automaticamente.</p>
      </div>

      <div class="aviso atencao">
        <span class="tag">Prazo</span>
        <h3>Documentação em até 48 horas</h3>
        <p>Após o registro da proposta, a documentação completa deve ser enviada em até 48 horas. Propostas com pendências podem ser canceladas.</p>
      </div>

      <div class="aviso">
        <span class="tag">Dica</span>
        <h3>Antes de começar</h3>
        <p>Tenha em mãos os dados do proponente, as informações da operação e os documentos digitalizados. Isso agiliza a análise e evita retrabalho.</p>
      </div>
    </div>

    <div class="sidebar-rodape">
      <div class="status conectando" id="statusSidebar">
        <span class="bolinha"></span>
        <span id="statusSidebarTexto">Conectando ao agente...</span>
      </div>

      <div class="linha-versao">
        <span class="rotulo">Versão instalada</span>
        <span class="valor" id="versaoBadge">v0.0</span>
      </div>


      <div class="sidebar-creditos">
        Canal oficial de formalização · GERAG<br>Banco da Amazônia
      </div>
    </div>
  </aside>

  <!-- ================= AREA DO CHAT (70%) ================= -->
  <main class="chat-area">
    <div class="chat-topo">
      <div class="esq">
        <h2>Agente SISpropostas</h2>
        <p>Registre sua proposta e envie a documentação pela conversa — o agente valida e processa os arquivos automaticamente.</p>
      </div>
      <div class="status-topo conectando" id="statusTopo">
        <span class="bolinha"></span>
        <span id="statusTopoTexto">Conectando...</span>
      </div>
    </div>
    <div class="chat-corpo">
      <div id="webchat"></div>
      <div id="chatCarregando" class="chat-carregando">
        <div class="spinner"></div>
        <p id="chatCarregandoTexto">Conectando ao agente...</p>
      </div>
    </div>
  </main>

</div>

<script src="https://cdn.botframework.com/botframework-webchat/4.16.0/webchat.js"></script>
<script>
  // ===================================================================
  // A variavel "versao" agora fica no topo do arquivo (dentro do <head>),
  // para ser facil de localizar e editar. Nao redeclare aqui.
  // ===================================================================

  // Link do tutorial de primeiro acesso.
  // Quando a página do tutorial estiver pronta, cole o endereço dela
  // entre as aspas abaixo (ex: "https://.../tutorial.html").
  const URL_TUTORIAL = "";

  // Repositório no GitHub (branch principal). A verificação de versão e
  // o download do instalador sempre usam a branch "main" para pegar o
  // conteúdo mais recente. Ajuste para "master" se sua branch for outra.
  const REPO_RAW = "https://raw.githubusercontent.com/sispropostas/sispropostas/main";

  // ATENCAO DE SEGURANCA: esta chave e um segredo estatico e reutilizavel,
  // visivel a qualquer pessoa que abra o codigo-fonte da pagina ou o
  // repositorio publico no GitHub. Ela nao expira sozinha como um token
  // de sessao. Considere rotacionar periodicamente ou migrar para um
  // esquema de token de curta duracao.
  const fluxoUrl = "https://8803c22341bfe1aa9c9014be446ff5.e9.environment.api.powerplatform.com:443/powerautomate/automations/direct/cu/01/workflows/e153f4b31e9d405e8206b7d31f536d49/triggers/manual/paths/invoke?api-version=1&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=AIi2t8cK47js_XEaaCxTA333lC0-BI_pOp80GE_dim0";
  const apiKey = "14480558-cf50-4b11-b0ff-2715f9bb5abc-ijms54fg285e5f2a46g8o-785e8-r5f-f4w8ew-r45s-45454fdf2e1a3fhik-pogf-etlphgs-4253yr3a-e985236-49862qi8-urmvuj6kv8e346m2-1jf9l3ld034j6kd8sl";

  // Exibe a versão no menu lateral (fonte única: a variável acima)
  document.getElementById('versaoBadge').textContent = 'v' + versao;

  // ---------- Tutorial (primeiro acesso) ----------
  function abrirTutorial() {
    if (!URL_TUTORIAL) {
      alert('O tutorial de envio de propostas será disponibilizado em breve.');
      return;
    }
    window.open(URL_TUTORIAL, '_blank');
  }

  // ---------- Status de conexão real ----------
  // Atualiza os dois indicadores (sidebar e topo) conforme o estado real
  // do Direct Line. Códigos: 1 Conectando | 2 Online | 3 Token expirado
  // | 4 Falha ao conectar | 5 Encerrado.
  function definirStatus(estado, texto) {
    ['statusSidebar', 'statusTopo'].forEach(function (id) {
      const el = document.getElementById(id);
      if (el) {
        el.classList.remove('online', 'conectando', 'offline');
        el.classList.add(estado);
      }
    });
    const t1 = document.getElementById('statusSidebarTexto');
    const t2 = document.getElementById('statusTopoTexto');
    if (t1) t1.textContent = texto;
    if (t2) t2.textContent = texto;

    // Overlay central do chat: visivel enquanto conecta ou em falha
    const ov = document.getElementById('chatCarregando');
    const ovTexto = document.getElementById('chatCarregandoTexto');
    if (ov && ovTexto) {
      if (estado === 'online') {
        ov.style.display = 'none';
      } else if (estado === 'conectando') {
        ov.classList.remove('erro');
        ov.style.display = 'flex';
        ovTexto.textContent = 'Conectando ao agente...';
      } else {
        ov.classList.add('erro');
        ov.style.display = 'flex';
        ovTexto.textContent = texto + ' — verifique sua internet e recarregue a página para tentar novamente.';
      }
    }
  }

  function aplicarStatusConexao(status) {
    switch (status) {
      case 0:
      case 1:
        definirStatus('conectando', 'Conectando...');
        break;
      case 2:
        definirStatus('online', 'Conectado');
        break;
      case 3:
        definirStatus('offline', 'Sessão expirada');
        break;
      case 4:
        definirStatus('offline', 'Falha na conexão');
        break;
      case 5:
        definirStatus('offline', 'Conexão encerrada');
        break;
      default:
        definirStatus('offline', 'Desconectado');
    }
  }

  // ---------- Inicialização do chat ----------
  function start() {
    return fetch(fluxoUrl, {
        method: "POST",
        headers: { "x-api-key": apiKey }
      })
      .then(function (res) {
        if (!res.ok) throw new Error('token ' + res.status);
        return res.json();
      })
      .then(function (dados) {
        const directLine = window.WebChat.createDirectLine({ token: dados.token });

        directLine.connectionStatus$.subscribe(function (status) {
          aplicarStatusConexao(status);
          if (status === 2) {
            directLine.postActivity({
              type: 'event',
              name: 'startConversation',
              from: { id: 'user' }
            }).subscribe();
          }
        });

        window.WebChat.renderWebChat(
          {
            directLine: directLine,
            locale: 'pt-BR',
            styleOptions: {
              accent: '#0F3325',
              backgroundColor: '#F4F6F4',
              bubbleBackground: '#FFFFFF',
              bubbleBorderColor: '#E2E6E1',
              bubbleBorderRadius: 12,
              bubbleFromUserBackground: '#0F3325',
              bubbleFromUserTextColor: '#FFFFFF',
              bubbleFromUserBorderRadius: 12,
              botAvatarBackgroundColor: '#0F3325',
              botAvatarInitials: 'IA',
              userAvatarBackgroundColor: '#3E9B36',
              userAvatarInitials: 'EU',
              sendBoxButtonColor: '#0F3325',
              sendBoxButtonColorOnHover: '#3E9B36',
              sendBoxButtonColorOnActive: '#1E5540',
              suggestedActionBackgroundColor: '#FFFFFF',
              suggestedActionTextColor: '#0F3325',
              suggestedActionBorderColor: '#0F3325',
              suggestedActionBorderRadius: 8
            }
          },
          document.getElementById('webchat')
        );
      })
      .catch(function (erro) {
        definirStatus('offline', 'Falha na conexão');
        console.error('Erro ao iniciar o chat:', erro);
      });
  }

  // ---------- Verificação de versão ----------
  function versaoMenorQue(a, b) {
    const pa = a.split('.').map(Number);
    const pb = b.split('.').map(Number);
    const n = Math.max(pa.length, pb.length);
    for (let i = 0; i < n; i++) {
      const na = pa[i] || 0;
      const nb = pb[i] || 0;
      if (na < nb) return true;
      if (na > nb) return false;
    }
    return false;
  }

  function checarVersao() {
    const urlSemCache = REPO_RAW + '/Sispropostas.html?nocache=' + Date.now();
    fetch(urlSemCache, { cache: 'no-store' })
      .then(function (resposta) {
        if (!resposta.ok) return null;
        return resposta.text();
      })
      .then(function (texto) {
        if (!texto) return;
        const achou = texto.match(/const\s+versao\s*=\s*["']([\d.]+)["']/);
        if (!achou) return;
        const versaoGithub = achou[1];
        if (versaoMenorQue(versao, versaoGithub)) {
          document.getElementById('versaoGithubTexto').textContent = versaoGithub;
          document.getElementById('avisoDesatualizado').style.display = 'block';
        }
      })
      .catch(function (erro) {
        // Sem internet ou GitHub indisponível: falha silenciosa.
        console.warn('Não foi possível checar atualização:', erro);
      });
  }

  // ---------- Atualizar (baixa o instalador mais recente) ----------
  function atualizarSispropostas() {
    const urlInstalador = 'https://raw.githubusercontent.com/sispropostas/sispropostas/92caf66bdd2971ef91ffdca40875b1dc982970db/Sispropostas_Instalador.cmd';
    fetch(urlInstalador, { cache: 'no-store' })
      .then(function (resposta) {
        if (!resposta.ok) throw new Error('Falha ao baixar: ' + resposta.status);
        return resposta.blob();
      })
      .then(function (blob) {
        const link = document.createElement('a');
        link.href = URL.createObjectURL(blob);
        link.download = 'Sispropostas_Instalador.cmd';
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
        URL.revokeObjectURL(link.href);
      })
      .catch(function (erro) {
        alert('Não foi possível baixar a atualização. Verifique sua conexão com a internet.\n\nDetalhe: ' + erro.message);
      });
  }

  // ---------- Boot ----------
  start();
  checarVersao();
</script>
</body>
</html>
