<script>
  import PageHeader from './PageHeader.svelte';
  import Sidebar from './Sidebar.svelte';
  import Dashboard from './Dashboard.svelte';
  import PageFooter from './PageFooter.svelte';

  export let rows = [];

  function selectRun(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="app">
  <PageHeader />
  <Sidebar />
  <Dashboard />
  <PageFooter />
  <p>{selectRun(rows)}</p>
</div>

<style>
  .app {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
