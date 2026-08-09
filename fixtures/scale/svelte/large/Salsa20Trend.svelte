<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForSalsa20(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="salsa20-trend">
  <TrendSparkline />
  <p>{trendForSalsa20(rows)}</p>
</div>

<style>
  .salsa20-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
