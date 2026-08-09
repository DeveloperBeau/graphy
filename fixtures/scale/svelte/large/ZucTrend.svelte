<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForZuc(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="zuc-trend">
  <TrendSparkline />
  <p>{trendForZuc(rows)}</p>
</div>

<style>
  .zuc-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
