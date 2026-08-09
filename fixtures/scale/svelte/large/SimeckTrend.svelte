<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForSimeck(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="simeck-trend">
  <TrendSparkline />
  <p>{trendForSimeck(rows)}</p>
</div>

<style>
  .simeck-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
