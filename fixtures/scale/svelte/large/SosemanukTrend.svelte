<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForSosemanuk(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="sosemanuk-trend">
  <TrendSparkline />
  <p>{trendForSosemanuk(rows)}</p>
</div>

<style>
  .sosemanuk-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
