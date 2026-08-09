<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForSimon(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="simon-trend">
  <TrendSparkline />
  <p>{trendForSimon(rows)}</p>
</div>

<style>
  .simon-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
