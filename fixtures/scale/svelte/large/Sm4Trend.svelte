<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForSm4(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="sm4-trend">
  <TrendSparkline />
  <p>{trendForSm4(rows)}</p>
</div>

<style>
  .sm4-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
