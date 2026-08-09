<script>
  import RunPicker from './RunPicker.svelte';
  import MetricTabs from './MetricTabs.svelte';
  import FilterBar from './FilterBar.svelte';

  export let rows = [];

  function collapseRail(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="sidebar">
  <RunPicker />
  <MetricTabs />
  <FilterBar />
  <p>{collapseRail(rows)}</p>
</div>

<style>
  .sidebar {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
