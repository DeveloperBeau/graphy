<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForTea(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="tea-trend">
  <TrendSparkline />
  <p>{trendForTea(rows)}</p>
</div>

<style>
  .tea-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
