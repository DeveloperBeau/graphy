<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForAria(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="aria-trend">
  <TrendSparkline />
  <p>{trendForAria(rows)}</p>
</div>

<style>
  .aria-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
