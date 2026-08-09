<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForFeal(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="feal-trend">
  <TrendSparkline />
  <p>{trendForFeal(rows)}</p>
</div>

<style>
  .feal-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
