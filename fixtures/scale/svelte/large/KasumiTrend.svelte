<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForKasumi(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="kasumi-trend">
  <TrendSparkline />
  <p>{trendForKasumi(rows)}</p>
</div>

<style>
  .kasumi-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
